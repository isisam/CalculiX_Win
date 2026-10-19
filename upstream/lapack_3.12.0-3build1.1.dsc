-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Format: 3.0 (quilt)
Source: lapack
Binary: liblapack3, liblapack64-3, liblapacke, liblapacke64, liblapacke-dev, liblapacke64-dev, libtmglib3, libtmglib64-3, libtmglib-dev, libtmglib64-dev, liblapack-dev, liblapack64-dev, liblapack-test, liblapack64-test, liblapack-doc, libblas3, libblas64-3, libblas-dev, libblas64-dev, libblas-test, libblas64-test
Architecture: any all
Version: 3.12.0-3build1.1
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Uploaders: Sébastien Villemot <sebastien@debian.org>, Mo Zhou <lumin@debian.org>
Homepage: https://www.netlib.org/lapack/
Standards-Version: 4.6.2
Vcs-Browser: https://salsa.debian.org/science-team/lapack
Vcs-Git: https://salsa.debian.org/science-team/lapack.git
Testsuite: autopkgtest
Testsuite-Triggers: build-essential, dpkg-dev, gcc, gfortran, python3
Build-Depends: debhelper-compat (= 13), dh-exec
Build-Depends-Arch: gfortran, python3
Build-Depends-Indep: doxygen, graphviz, rename
Package-List:
 libblas-dev deb libdevel optional arch=any
 libblas-test deb devel optional arch=any
 libblas3 deb libs optional arch=any
 libblas64-3 deb libs optional arch=any
 libblas64-dev deb libdevel optional arch=any
 libblas64-test deb devel optional arch=any
 liblapack-dev deb libdevel optional arch=any
 liblapack-doc deb doc optional arch=all
 liblapack-test deb devel optional arch=any
 liblapack3 deb libs optional arch=any
 liblapack64-3 deb libs optional arch=any
 liblapack64-dev deb libdevel optional arch=any
 liblapack64-test deb devel optional arch=any
 liblapacke deb libs optional arch=any
 liblapacke-dev deb libdevel optional arch=any
 liblapacke64 deb libs optional arch=any
 liblapacke64-dev deb libdevel optional arch=any
 libtmglib-dev deb libdevel optional arch=any
 libtmglib3 deb libs optional arch=any
 libtmglib64-3 deb libs optional arch=any
 libtmglib64-dev deb libdevel optional arch=any
Checksums-Sha1:
 3661a879f31b517f43db2b94a1f2831da3235138 7933607 lapack_3.12.0.orig.tar.gz
 c5acc3274664b7480fd74a66f5595f5962828e32 28916 lapack_3.12.0-3build1.1.debian.tar.xz
Checksums-Sha256:
 eac9570f8e0ad6f30ce4b963f4f033f0f643e7c3912fc9ee6cd99120675ad48b 7933607 lapack_3.12.0.orig.tar.gz
 e97519fe8f738e8040f2e5b35dded211f60923bbaba34f33387c2cdb0488c358 28916 lapack_3.12.0-3build1.1.debian.tar.xz
Files:
 c1b38bef123584d86a1bd8000784a7b2 7933607 lapack_3.12.0.orig.tar.gz
 0511b96d608feadd7b772258d660e914 28916 lapack_3.12.0-3build1.1.debian.tar.xz
Original-Maintainer: Debian Science Team <debian-science-maintainers@lists.alioth.debian.org>
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEVovyKmYzfL/Jprm3LIPbyOm9DjcFAma1gnwACgkQLIPbyOm9
DjdY6xAAiHWNcQZvhvLChCkE48H9vEVTFYV3cFu1qhLWBW7Vk6uiyIny6U6fAxnB
uB3GDFqTtJ3iK67GEHPLTwP7OB9eCjclLVNuwmPp/duoFgn0uJlzEXZjXxOsrr7z
2kaqAJsnxealVindPi9TiiSdCq+YFyPDW23jN5GOnSX55F8khYBJykXTmBzF5Oe6
qqCw+7/X4h0dPN3NqLWZjFspmiyqq5ChXBNFxQdvI6eLU8SLzY638Sysk2S4eXnQ
kPZJKtIXjoM8Ellq9USWx5ngciVxMi2byTpcPaSR/v1jk5pJ+lE0Xvp/l9wNA8rK
q7d9crP3Nq+6sVyN6z2Bk6cl6rgtyFHTmm+RxNn2JDd16BW6LnE0+bWPT4ekokuB
rlgf9pe5ZOJ+vDO3xqhOVjU2ZgTuk1HwRxGJFWS581E5L2NM7qEBwpKHj+OXDB09
qqaEiNMwpIxDEgkIROpt1Y0tZByXU+HF/6zfJlHXk89Zqx8WKrHwnD1YIga5W5qF
xkUV1X+lzNK0uu3vI4NXBIni8GiJu5kXrSfQCtCe3Wczjiz8XCtMWEfGT5gK7Qpb
laeUEw/SQK3EymnevZXQQE5nCFAdX+91MAxubMU0YjTF1wyyEqWOKzmdng8lZKMe
6VC6AaaYrMPUAef52ZIPUeDhGKirUwvFhMqpUDuLNrCyY9JhRf4=
=xIGQ
-----END PGP SIGNATURE-----
