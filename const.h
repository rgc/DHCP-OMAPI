static int
not_here(char *s)
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static double
constant_I(char *name, int len, int arg)
{
  if (strEQ(name+6,"SUCCESS")) {
    return ISC_R_SUCCESS;
  }
  if (strEQ(name+6,"NOMEMORY")) {
    return ISC_R_NOMEMORY;
  }
  if (strEQ(name+6,"TIMEDOUT")) {
    return ISC_R_TIMEDOUT;
  }
  if (strEQ(name+6,"NOTHREADS")) {
    return ISC_R_NOTHREADS;
  }
  if (strEQ(name+6,"ADDRNOTAVAIL")) {
    return ISC_R_ADDRNOTAVAIL;
  }
  if (strEQ(name+6,"ADDRINUSE")) {
    return ISC_R_ADDRINUSE;
  }
  if (strEQ(name+6,"NOPERM")) {
    return ISC_R_NOPERM;
  }
  if (strEQ(name+6,"NOCONN")) {
    return ISC_R_NOCONN;
  }
  if (strEQ(name+6,"NETUNREACH")) {
    return ISC_R_NETUNREACH;
  }
  if (strEQ(name+6,"HOSTUNREACH")) {
    return ISC_R_HOSTUNREACH;
  }
  if (strEQ(name+6,"NETDOWN")) {
    return ISC_R_NETDOWN;
  }
  if (strEQ(name+6,"HOSTDOWN")) {
    return ISC_R_HOSTDOWN;
  }
  if (strEQ(name+6,"CONNREFUSED")) {
    return ISC_R_CONNREFUSED;
  }
  if (strEQ(name+6,"NORESOURCES")) {
    return ISC_R_NORESOURCES;
  }
  if (strEQ(name+6,"EOF")) {
    return ISC_R_EOF;
  }
  if (strEQ(name+6,"BOUND")) {
    return ISC_R_BOUND;
  }
  if (strEQ(name+6,"TASKDONE")) {
    return ISC_R_TASKDONE;
  }
  if (strEQ(name+6,"LOCKBUSY")) {
    return ISC_R_LOCKBUSY;
  }
  if (strEQ(name+6,"EXISTS")) {
    return ISC_R_EXISTS;
  }
  if (strEQ(name+6,"NOSPACE")) {
    return ISC_R_NOSPACE;
  }
  if (strEQ(name+6,"CANCELED")) {
    return ISC_R_CANCELED;
  }
  if (strEQ(name+6,"TASKNOSEND")) {
    return ISC_R_TASKNOSEND;
  }
  if (strEQ(name+6,"SHUTTINGDOWN")) {
    return ISC_R_SHUTTINGDOWN;
  }
  if (strEQ(name+6,"NOTFOUND")) {
    return ISC_R_NOTFOUND;
  }
  if (strEQ(name+6,"UNEXPECTEDEND")) {
    return ISC_R_UNEXPECTEDEND;
  }
  if (strEQ(name+6,"FAILURE")) {
    return ISC_R_FAILURE;
  }
  if (strEQ(name+6,"IOERROR")) {
    return ISC_R_IOERROR;
  }
  if (strEQ(name+6,"NOTIMPLEMENTED")) {
    return ISC_R_NOTIMPLEMENTED;
  }
  if (strEQ(name+6,"UNBALANCED")) {
    return ISC_R_UNBALANCED;
  }
  if (strEQ(name+6,"NOMORE")) {
    return ISC_R_NOMORE;
  }
  if (strEQ(name+6,"INVALIDFILE")) {
    return ISC_R_INVALIDFILE;
  }
  if (strEQ(name+6,"BADBASE64")) {
    return ISC_R_BADBASE64;
  }
  if (strEQ(name+6,"UNEXPECTEDTOKEN")) {
    return ISC_R_UNEXPECTEDTOKEN;
  }
  if (strEQ(name+6,"QUOTA")) {
    return ISC_R_QUOTA;
  }
  if (strEQ(name+6,"UNEXPECTED")) {
    return ISC_R_UNEXPECTED;
  }
  if (strEQ(name+6,"ALREADYRUNNING")) {
    return ISC_R_ALREADYRUNNING;
  }
  if (strEQ(name+6,"HOSTUNKNOWN")) {
    return ISC_R_HOSTUNKNOWN;
  }
  if (strEQ(name+6,"VERSIONMISMATCH")) {
    return ISC_R_VERSIONMISMATCH;
  }
  if (strEQ(name+6,"PROTOCOLERROR")) {
    return ISC_R_PROTOCOLERROR;
  }
  if (strEQ(name+6,"INVALIDARG")) {
    return ISC_R_INVALIDARG;
  }
  if (strEQ(name+6,"NOTCONNECTED")) {
    return ISC_R_NOTCONNECTED;
  }
  if (strEQ(name+6,"NOTYET")) {
    return ISC_R_NOTYET;
  }
  if (strEQ(name+6,"UNCHANGED")) {
    return ISC_R_UNCHANGED;
  }
  if (strEQ(name+6,"MULTIPLE")) {
    return ISC_R_MULTIPLE;
  }
  if (strEQ(name+6,"KEYCONFLICT")) {
    return ISC_R_KEYCONFLICT;
  }
  if (strEQ(name+6,"BADPARSE")) {
    return ISC_R_BADPARSE;
  }
  if (strEQ(name+6,"NOKEYS")) {
    return ISC_R_NOKEYS;
  }
  if (strEQ(name+6,"KEY_UNKNOWN")) {
    return ISC_R_KEY_UNKNOWN;
  }
  if (strEQ(name+6,"INVALIDKEY")) {
    return ISC_R_INVALIDKEY;
  }
  if (strEQ(name+6,"INCOMPLETE")) {
    return ISC_R_INCOMPLETE;
  }
  if (strEQ(name+6,"FORMERR")) {
    return ISC_R_FORMERR;
  }
  if (strEQ(name+6,"SERVFAIL")) {
    return ISC_R_SERVFAIL;
  }
  if (strEQ(name+6,"NXDOMAIN")) {
    return ISC_R_NXDOMAIN;
  }
  if (strEQ(name+6,"NOTIMPL")) {
    return ISC_R_NOTIMPL;
  }
  if (strEQ(name+6,"REFUSED")) {
    return ISC_R_REFUSED;
  }
  if (strEQ(name+6,"YXDOMAIN")) {
    return ISC_R_YXDOMAIN;
  }
  if (strEQ(name+6,"YXRRSET")) {
    return ISC_R_YXRRSET;
  }
  if (strEQ(name+6,"NXRRSET")) {
    return ISC_R_NXRRSET;
  }
  if (strEQ(name+6,"NOTAUTH")) {
    return ISC_R_NOTAUTH;
  }
  if (strEQ(name+6,"NOTZONE")) {
    return ISC_R_NOTZONE;
  }
  if (strEQ(name+6,"BADSIG")) {
    return ISC_R_BADSIG;
  }
  if (strEQ(name+6,"BADKEY")) {
    return ISC_R_BADKEY;
  }
  if (strEQ(name+6,"BADTIME")) {
    return ISC_R_BADTIME;
  }
  if (strEQ(name+6,"NOROOTZONE")) {
    return ISC_R_NOROOTZONE;
  }
  if (strEQ(name+6,"DESTADDRREQ")) {
    return ISC_R_DESTADDRREQ;
  }
  if (strEQ(name+6,"CROSSZONE")) {
    return ISC_R_CROSSZONE;
  }
  if (strEQ(name+6,"NO_TSIG")) {
    return ISC_R_NO_TSIG;
  }
  if (strEQ(name+6,"NOT_EQUAL")) {
    return ISC_R_NOT_EQUAL;
  }
  if (strEQ(name+6,"CONNRESET")) {
    return ISC_R_CONNRESET;
  }

  errno = EINVAL;
  return 0;
}

static double
constant_D(char *name, int len, int arg)
{
    if (1 + 7 >= len ) {
	errno = EINVAL;
	return 0;
    }
    switch (name[1 + 7]) {
    case 'C':
	if (strEQ(name + 1, "HCPCTL_CREATE")) {	/* D removed */
#ifdef OMAPI_CREATE
	    return OMAPI_CREATE;
#else
	    goto not_there;
#endif
	}
    case 'E':
	if (strEQ(name + 1, "HCPCTL_EXCL")) {	/* D removed */
#ifdef OMAPI_EXCL
	    return OMAPI_EXCL;
#else
	    goto not_there;
#endif
	}
    case 'U':
	if (strEQ(name + 1, "HCPCTL_UPDATE")) {	/* D removed */
#ifdef OMAPI_UPDATE
	    return OMAPI_UPDATE;
#else
	    goto not_there;
#endif
	}
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}

static double
constant(char *name, int len, int arg)
{
    errno = 0;
    switch (name[0 + 0]) {
    case 'D':
	return constant_D(name, len, arg);
    case 'I':
        return constant_I(name,len,arg);
    case 'n':
	if (strEQ(name + 0, "null_handle")) {	/*  removed */
#ifdef null_handle
	    return null_handle;
#else
	    goto not_there;
#endif
	}
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}
