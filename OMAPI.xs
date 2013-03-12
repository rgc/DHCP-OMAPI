#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <dhcpctl.h>
#include <isc-dhcp/result.h>
#include <isc-dhcp/types.h>
#include <omapip/omapip.h>
#include "const.h"

#ifndef HAVE_OMAPI_GENERIC_OBJECT_T
typedef struct __omapi_generic_object {
        OMAPI_OBJECT_PREAMBLE;
        omapi_value_t **values;
        u_int8_t *changed;
        int nvalues, va_max;
} omapi_generic_object_t;
#endif

static dhcpctl_handle *
sv2dhcpctl_handle(SV *sv)
{
  if (SvROK(sv) && sv_isa(sv,"DHCP::OMAPI::Handle"))
    return (dhcpctl_handle *)SvIV(SvRV(sv));
  else
    croak("Argument to sv2dhcpctl_handle not blessed package \"DHCP::OMAPI::Handle\"");
}

MODULE = DHCP::OMAPI::Handle        PACKAGE = DHCP::OMAPI::Handle       PREFIX = dhcpctl_
PROTOTYPES: ENABLE

void
initialize(self)
SV *self
CODE:
{
  dhcpctl_initialize();
}

dhcpctl_handle *
new(self)
SV *self
CODE:
{
  dhcpctl_handle *handle = (dhcpctl_handle *)safemalloc(sizeof(dhcpctl_handle));

  memset(handle,0,sizeof(*handle));
  RETVAL = handle;
}
OUTPUT:
	RETVAL

int
dhcpctl_disconnect(self)
dhcpctl_handle *self
PREINIT:
isc_result_t status;
CODE:
{
	RETVAL = 1;
	status = omapi_disconnect ((*self) -> outer -> outer, 1);
	if (status != ISC_R_SUCCESS) {
		fprintf (stderr, "disconnect failed (%s)\n", isc_result_totext (status));
		RETVAL = 0;
	}
}
OUTPUT:
	RETVAL

int
dhcpctl_connect(self,host,port,key_name,algorithm,secret)
dhcpctl_handle *self
SV *host
int port
SV *key_name
SV *algorithm
SV *secret
CODE:
{
  dhcpctl_handle authenticator;
  dhcpctl_status ret;

  // rgc - timeout start 
  static void null(int i) {}

  int timeout = 60;

  void (*old_handler)();

  old_handler = signal(SIGALRM, null);
  (void) alarm(timeout);
  // rgc - timeout end

  if (SvOK(key_name) && SvOK(algorithm) && SvOK(secret))
    {
      dhcpctl_handle authenticator;
      char *str;
      size_t len;

      str = SvPV(secret,len);
      memset(&authenticator,0,sizeof(authenticator));
      dhcpctl_new_authenticator(&authenticator,SvPV_nolen(key_name),SvPV_nolen(algorithm),str,len);
      ret = dhcpctl_connect(self,SvPV_nolen(host),port,authenticator);
    }
  else
    {
      //fprintf(stderr,"connecting to %s:%d\n",SvPV_nolen(host),port);
      ret = dhcpctl_connect(self,SvPV_nolen(host),port,NULL);
    }

  // rgc - timeout start 
  (void) alarm(0);
  (void) signal(SIGALRM, old_handler);
  // rgc - timeout end

  RETVAL = (int)ret;
}
OUTPUT:
	RETVAL

dhcpctl_handle *
dhcpctl_new_object(object,connection,object_type)
dhcpctl_handle *object
dhcpctl_handle *connection
char *object_type
CODE:
{
  dhcpctl_new_object(object,*connection,object_type);
  RETVAL = object;
}
OUTPUT:
	RETVAL

int
dhcpctl_open_object(object,connection,flags)
dhcpctl_handle *object
dhcpctl_handle *connection
int flags
CODE:
{
  dhcpctl_status ret = dhcpctl_open_object(*object,*connection,flags);

  //fprintf(stderr,"open_object flags=%d\n",flags);
  if (ret != ISC_R_SUCCESS)
    {
      goto cleanup;
    }

  dhcpctl_wait_for_completion(*object,&ret);

  cleanup:
  RETVAL = (int)ret;
}
OUTPUT:
	RETVAL

int
dhcpctl_object_update(object,connection)
dhcpctl_handle *object
dhcpctl_handle *connection
CODE:
{
  dhcpctl_status ret = dhcpctl_object_update(*connection,*object);
	
  if (ret != ISC_R_SUCCESS)
    {
      fprintf(stderr,"object_update failed\n");
      goto cleanup;
    }

  dhcpctl_wait_for_completion(*object,&ret);
    
  cleanup:
  RETVAL = (int)ret;
}
OUTPUT:
	RETVAL

SV *
dhcpctl_get_value(object,attribute)
dhcpctl_handle *object
char *attribute
CODE:
{
  dhcpctl_data_string value = NULL;
  SV *out = NULL;
  dhcpctl_status ret = dhcpctl_get_value(&value,*object,attribute);
  if (ret == ISC_R_SUCCESS)
    {
      out = newSVpv(value->value,value->len);
      dhcpctl_data_string_dereference(&value,MDL);
    }
  else
    {
      out = &PL_sv_undef;
    }
  RETVAL = out;
}
OUTPUT:
	RETVAL

void
dhcpctl_attributes(object)
dhcpctl_handle *object
PREINIT:
  dhcpctl_remote_object_t *r = (dhcpctl_remote_object_t *)*object;
  omapi_generic_object_t *g = (omapi_generic_object_t *)(r->inner);
  int i;
PPCODE:
  if (g != NULL)
    {
      for (i = 0; i < g->nvalues; i++) 
	{
	  omapi_value_t *v = g->values[i];
	  XPUSHs(newSVpv(v->name->value,(int)v->name->len));
	}
    }

void
dhcpctl_set_value(object, value, attribute)
dhcpctl_handle *object
SV *value
char *attribute
CODE:
{
  dhcpctl_data_string data = NULL;
  char *str;
  size_t len;

  str = SvPV(value,len);
  omapi_data_string_new(&data,len,MDL);
  memcpy(data->value,str,len);
  dhcpctl_set_value(*object,data,attribute);
}

char *
result_totext(self,res)
SV *self
int res
CODE:
{
  RETVAL = (char *)isc_result_totext((isc_result_t)res);
}
OUTPUT:
        RETVAL


MODULE = DHCP::OMAPI		PACKAGE = DHCP::OMAPI


double
constant(sv,arg)
    PREINIT:
	STRLEN		len;
    INPUT:
	SV *		sv
	char *		s = SvPV(sv, len);
	int		arg
    CODE:
	RETVAL = constant(s,len,arg);
    OUTPUT:
	RETVAL

