#!/bin/bash

### cleanup first
ncftp -u"$FTPUSER" -p"$FTPPASS" $FTPSERVER <<EOF
cd $REMOTEDIR
rm -rf $TARGET
quit
EOF
### Find out if cleanup failed or not ###
if [ "$?" == "0" ]; then
 echo "Cleanup successful!"
else
 echo "Cleanup failed!"
fi

### transfer
ncftpput -R -m -u"$FTPUSER" -p"$FTPPASS" -W "rmdir $REMOTEDIR" $FTPSERVER $REMOTEDIR$TARGET $LOCALDIR
### Find out if transfer failed or not ###
if [ "$?" == "0" ]; then
 echo "Transfer successful!"
else
 echo "Transfer failed!"
fi

