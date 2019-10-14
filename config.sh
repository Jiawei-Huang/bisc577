source /home/cmb-16/mjc/shared/virtualenvs/python2.7/bin/activate
source /home/cmb-16/mjc/shared/software_packages/hisat2-2.1.0/setup_hisat.sh


export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/usc/gnu/gcc/5.3.0/lib64
export PATH=/home/cmb-16/mjc/shared/bin/:$PATH

if [ ! -v TMPDIR ]; then
export TMPDIR=.
fi

