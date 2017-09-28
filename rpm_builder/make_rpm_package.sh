umask 0022

if [ -z $USERNAME ]; then USERNAME=$(whoami); fi
BUILDDIR_tmp="/tmp/pygrib_build_${USERNAME}"

if [ -z $1 ]; then
    echo "You must supply a OS version"
    echo "Usage: ${0} rhel6|rhel7"
    exit 1
fi

OS=${1,,}

if [ ! -z "${2}" ]; then BUILDDIR_tmp="${2}"; fi
 
mkdir -p ${BUILDDIR_tmp}/rpmbuild/BUILD
mkdir -p ${BUILDDIR_tmp}/rpmbuild/BUILDROOT
mkdir -p ${BUILDDIR_tmp}/rpmbuild/RPMS
mkdir -p ${BUILDDIR_tmp}/rpmbuild/SOURCES
mkdir -p ${BUILDDIR_tmp}/rpmbuild/SPECS
mkdir -p ${BUILDDIR_tmp}/rpmbuild/SRPMS

mkdir -p ${HOME}/rpmbuild/BUILD
mkdir -p ${HOME}/rpmbuild/BUILDROOT
mkdir -p ${HOME}/rpmbuild/RPMS
mkdir -p ${HOME}/rpmbuild/SOURCES
mkdir -p ${HOME}/rpmbuild/SPECS
mkdir -p ${HOME}/rpmbuild/SRPMS

if [ ! -d ${BUILDDIR_tmp}/rpmbuild/BUILDROOT ]; then
    echo "ERROR - Cannot create BUILDROOT: ${BUILDDIR_tmp}/rpmbuild/BUILDROOT"
    exit 1
fi

if [ ! -d ${BUILDDIR_tmp}/rpmbuild/SPECS ]; then
    echo "ERROR - Cannot create SPECS dir: ${BUILDDIR_tmp}/rpmbuild/SPECS"
    exit 1
fi

cp -fv pygrib_${OS}.spec ${BUILDDIR_tmp}/rpmbuild/SPECS/pygrib.spec
Version=$(head -15 ${BUILDDIR_tmp}/rpmbuild/SPECS/pygrib.spec | grep 'Version:' | awk -F: '{ print $2 }')
Version=$( echo "${Version}" | sed s/' '//g)
Release=$(head -15 ${BUILDDIR_tmp}/rpmbuild/SPECS/pygrib.spec | grep 'Release:' | awk -F: '{ print $2 }')
Release=$( echo "${Release}" | sed s/' '//g)

Build="${BUILDDIR_tmp}/rpmbuild/BUILD/pygrib_server"
mkdir -pv "${Build}"

if [ ! -d "${Build}" ]; then
    echo "ERROR - Cannot make Build: ${Build}"
    exit 1;
fi

cd ../
python setup.py clean
python setup.py build

PYVER="2"
PYMINVER="7"
if [ "${OS}" == "rhel6" ]; then PYMINVER="6"; fi

mkdir -p ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages
chmod -R 755 ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages
mkdir -p ${Build}/usr/bin
chmod -R 755 ${Build}/usr/bin
mkdir -p ${Build}/usr/share/doc/pygrib/docs
chmod -R 755 ${Build}/usr/share/doc/pygrib/docs
mkdir -p ${Build}/usr/share/doc/pygrib/ncepgrib2_docs
chmod -R 755 ${Build}/usr/share/doc/pygrib/ncepgrib2_docs
cp -fv build/lib.linux-x86_64-${PYVER}.${PYMINVER}/g2clib.so ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages
cp -fv build/lib.linux-x86_64-${PYVER}.${PYMINVER}/pygrib.so ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages
cp -fv build/lib.linux-x86_64-${PYVER}.${PYMINVER}/ncepgrib2.py ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages
cp -fv  build/lib.linux-x86_64-${PYVER}.${PYMINVER}/redtoreg.so ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages
chmod 755 ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages/*.so*
chmod 644 ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages/*.py*
cp -fv docs/*  ${Build}/usr/share/doc/pygrib/docs/.
chmod 644  ${Build}/usr/share/doc/pygrib/docs/*
cp -fv ncepgrib2_docs/* ${Build}/usr/share/doc/pygrib/ncepgrib2_docs/.
chmod 644 ${Build}/usr/share/doc/pygrib/ncepgrib2_docs/*
cp -fv COPYING ${Build}/usr/share/doc/pygrib/.
cp -fv README.md ${Build}/usr/share/doc/pygrib/.
chmod 644 ${Build}/usr/share/doc/pygrib/COPYING
chmod 644 ${Build}/usr/share/doc/pygrib/README.md
python -O -m py_compile ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages/ncepgrib2.py
cp -fv build/scripts-${PYVER}.${PYMINVER}/grib_list ${Build}/usr/bin
cp -fv build/scripts-${PYVER}.${PYMINVER}/cnvgrib1to2 ${Build}/usr/bin
cp -fv build/scripts-${PYVER}.${PYMINVER}/grib_repack ${Build}/usr/bin
cp -fv build/scripts-${PYVER}.${PYMINVER}/cnvgrib2to1 ${Build}/usr/bin
chmod 755 ${Build}/usr/bin/*

cat > ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages/pygrib-${Version}-py${PYVER}.${PYMINVER}.egg-info <<EOF
Metadata-Version: 1.0
Name: pygrib
Version: ${Version}
Summary: Python module for reading/writing GRIB files
Home-page: https://github.com/jswhit/pygrib
Author: Jeff Whitaker
Author-email: jeffrey.s.whitaker@noaa.gov
License: MIT
Download-URL: http://python.org/pypi/pygrib
Description: UNKNOWN
Platform: ${OS}
Classifier: Development Status :: 4 - Beta
Classifier: Programming Language :: Python :: 2
Classifier: Programming Language :: Python :: 2.4
Classifier: Programming Language :: Python :: 2.5
Classifier: Programming Language :: Python :: 2.6
Classifier: Programming Language :: Python :: 2.7
Classifier: Programming Language :: Python :: 3
Classifier: Programming Language :: Python :: 3.3
Classifier: Programming Language :: Python :: 3.4
Classifier: Programming Language :: Python :: 3.5
Classifier: Programming Language :: Python :: 3.6
Classifier: Intended Audience :: Science/Research
Classifier: License :: OSI Approved
Classifier: Topic :: Software Development :: Libraries :: Python Modules

EOF

chmod 644 ${Build}/usr/lib64/python${PYVER}.${PYMINVER}/site-packages/pygrib-${Version}-py${PYVER}.${PYMINVER}.egg-info

cd ${Build}
if [ -f ${HOME}/rpmbuild/BUILD/pygrib.tar.gz ]; then
    rm -f ${HOME}/rpmbuild/BUILD/pygrib.tar.gz
fi
tar cfz ${HOME}/rpmbuild/BUILD/pygrib.tar.gz *

cd ${BUILDDIR_tmp}/rpmbuild/SPECS
rpmbuild -ba --buildroot=${BUILDDIR_tmp}/rpmbuild/BUILDROOT pygrib.spec

rm -f ${HOME}/rpmbuild/BUILD/pygrib.tar.gz
rm -rf ${BUILDDIR_tmp}


