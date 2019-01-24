#!/bin/sh

CONFIG=$1
echo ${CONFIG}
if [ -f ${CONFIG} ] ; then
    . ${CONFIG}
else
    echo "${CONFIG}が見つかりません"
    RETVAL=1
    exit
fi 

echo "*** deploy(d) or get UPDATE_FAILED event(g) or validation(v) or cancel(c)? [d/g/v/c]"
read ANSWER

case ${ANSWER} in 
    [d/D] )
        echo "deploy start..."
        #aws cloudformation deploy --stack-name ${STACKNAME} --template-file --capabilities CAPABILITY_IAM --profile ${PROFILE} --parameter-overrides ${PARAMS}
    ;;
    [g/G] )
        echo "get UPDATE_FAILED event..."
        aws cloudformation describe-stack-events --stack-name ${STACKNAME} --profile ${PROFILE} | grep "UPDATE_FAILED" | sed -n '1p'
    ;;
    [v/V] )
        echo "validation template..."
        aws cloudformation validate-template --template-body file://${TEMPLATE} --profile ${PROFILE}
    ;;
    [c/C] )
        echo "Cancel..."
        exit
    ;; 
esac
