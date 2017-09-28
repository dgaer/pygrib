BuildArch: x86_64
Name: pygrib
Version: 2.0.2      
Release: 1.el6.x86_64
Summary: Python module for reading and writing GRIB (editions 1 and 2) files
Group: Applications/Engineering
License: MIT       
Distribution: RHEL Install
URL: https://github.com/jswhit/pygrib
Vendor: jswhit 

Requires: grib_api
Requires: libc.so.6()(64bit)
Requires: libgrib_api.so.0()(64bit)
Requires: libjasper.so.1()(64bit)
Requires: libpng12.so.0()(64bit)
Requires: libpthread.so.0()(64bit)
Requires: python(abi) = 2.6
# Can use python-basemap or pyproj
# Requires: pyproj
Requires: python-basemap
# For source build
# Requires: grib_api-devel 
# Requires: grib_api-static

%description
Python wrapper to provide python interfaces to the grib library.

GRIB is the the World Meteorological Organization (WMO) standard for
distributing gridded data. This module contains python interfaces for reading
and writing GRIB data using the ECMWF GRIB API C library, and the NCEP GRIB2
C library, as well as command-line utilities for listing and re-packing GRIB
files.

%install
tar xvf pygrib.tar.gz -C $RPM_BUILD_ROOT

%files
%attr(0755, root, root) "/usr/lib64/python2.6/site-packages/g2clib.so"
%attr(0755, root, root) "/usr/lib64/python2.6/site-packages/pygrib.so"
%attr(0755, root, root) "/usr/lib64/python2.6/site-packages/redtoreg.so"
%attr(0644, root, root) "/usr/lib64/python2.6/site-packages/ncepgrib2.py"
%attr(0644, root, root) "/usr/lib64/python2.6/site-packages/ncepgrib2.pyc"
%attr(0644, root, root) "/usr/lib64/python2.6/site-packages/ncepgrib2.pyo"
%attr(0644, root, root) "/usr/lib64/python2.6/site-packages/pygrib-2.0.2-py2.6.egg-info"
%attr(0755, root, root) "/usr/bin/grib_list"
%attr(0755, root, root) "/usr/bin/cnvgrib1to2"
%attr(0755, root, root) "/usr/bin/grib_repack"
%attr(0755, root, root) "/usr/bin/cnvgrib2to1"
%dir %attr(0755, root, root) "/usr/share/doc/pygrib"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/COPYING"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/README.md"
%dir %attr(0755, root, root) "/usr/share/doc/pygrib/docs"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/api-objects.txt"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/class-tree.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/crarr.png"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/epydoc.css"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/epydoc.js"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/help.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/identifier-index.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/index.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/module-tree.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/pygrib-module.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/pygrib.gribmessage-class.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/pygrib.index-class.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/pygrib.open-class.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/docs/redirect.html"
%dir %attr(0755, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/api-objects.txt"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/class-tree.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/crarr.png"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/epydoc.css"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/epydoc.js"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/help.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/identifier-index.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/index.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/module-tree.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/ncepgrib2-module.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/ncepgrib2-pysrc.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/ncepgrib2.Grib2Encode-class.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/ncepgrib2.Grib2Message-class.html"
%doc %attr(0644, root, root) "/usr/share/doc/pygrib/ncepgrib2_docs/redirect.html"

%changelog
* Wed Sep 27 2017 jswhit https://github.com/jswhit/pygrib
- Initial RPM build 


