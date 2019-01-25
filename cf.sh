#!/bin/sh

# CONFIGファイルの取得
CONFIG=$1

# CONFIGファイルの存在確認とパラメータの取得
if [ -f ${CONFIG} ] ; then
    STACKNAME=`grep -w "^STACKNAME" ${CONFIG} | cut -d"=" -f2` 
    TEMPLATE=`grep -w "^TEMPLATE" ${CONFIG} | cut -d"=" -f2`
    PROFILE=`grep -w "^PROFILE" ${CONFIG} | cut -d"=" -f2`

    pidx=`grep -n -w "^\[PARAMETER-OVERRIDES\]" ${CONFIG} | cut -d":" -f1`
    pidx_sft=`expr ${pidx} + 1`
    OVERRIDLIST=`tail -n+${pidx_sft} ${CONFIG}|xargs`

    echo "+++CONFIGパラメータの確認+++"
    echo "STACKNAME = ${STACKNAME}"
    echo "TEMPLATE = ${TEMPLATE}"
    echo "PROFILE = ${PROFILE}"
    echo "OVERRIDLIST = [${OVERRIDLIST}]"
    echo "+++++++++++++++++++++++++"
else
    echo "${CONFIG}が見つかりません"
    RETVAL=1
    exit
fi 

echo "*** deploy(d) or get UPDATE_FAILED event(g) or validation(v) or delete(del) or cancel(c)? [d/g/v/del/c]"
read ANSWER

case ${ANSWER} in 
    [d/D] )
        echo "Deploy start..."
        aws cloudformation deploy --stack-name ${STACKNAME} --template-file ${TEMPLATE} --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --profile ${PROFILE} --parameter-overrides ${OVERRIDLIST}
    ;;
    [g/G] )
        echo "Get FAILED event..."
        aws cloudformation describe-stack-events --stack-name ${STACKNAME} --profile ${PROFILE} | grep -E 'UPDATE_FAILED|CREATE_FAILED' | sed -n '1p'
    ;;
    [v/V] )
        echo "Validation template..."
        aws cloudformation validate-template --profile ${PROFILE} --template-body file://${TEMPLATE}
    ;;
    "del" | "DELETE" )
        echo "delete stach. Are you sure? [y]"
        read OK
        if test OK='y' -o OK='Y' ; then
            echo "DELETE stack!!!"
            aws cloudformation delete-stack --profile ${PROFILE} --stack-name ${STACKNAME}
        else
            echo "Delete stack cenceled..."
            exit
        fi
    ;;
    [c/C] )
        echo "Cancel..."
        exit
    ;; 
esac