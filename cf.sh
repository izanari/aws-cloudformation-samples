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
    OVERRIDELIST=`tail -n+${pidx_sft} ${CONFIG}|xargs`
else
    echo "${CONFIG}が見つかりません"
    RETVAL=1
    exit
fi 

# NULLチェック
NULL_FLG=0
OVERRIDE_FLG=0
if [ "${STACKNAME}" = "" ] ; then NULL_FLG=1 ; echo "[ERROR] STACKNAMEが設定されていません。" ; fi
if [ "${TEMPLATE}" = "" ] ; then NULL_FLG=1 ; echo "[ERROR] TEMPLATEが設定されていません。" ; fi
if [ "${PROFILE}" = "" ] ; then NULL_FLG=1 ; echo "[ERROR] PROFILEが設定されていません。" ; fi
if [ "${OVERRIDELIST}" = "" ] ; then OVERRIDE_FLG=1 ; fi

# NULLチェックの対象があればシェルを終了させる
if [ ${NULL_FLG} -eq 1 ] ; then exit; fi

echo "+++CONFIGパラメータの確認+++"
echo "STACKNAME   = ${STACKNAME}"
echo "TEMPLATE    = ${TEMPLATE}"
echo "PROFILE     = ${PROFILE}"
echo "OVERRIDLIST = [${OVERRIDELIST}]"
echo "+++++++++++++++++++++++++"

echo "*** deploy(d) or get UPDATE_FAILED event(g) or validation(v) or cancel(c)? [d/g/v/c]"
read ANSWER

case ${ANSWER} in 
    [d/D] )
        echo "deploy start..."
        if [ ${OVERRIDE_FLG} -eq 1 ] ; then
            aws cloudformation deploy --stack-name ${STACKNAME} --template-file ${TEMPLATE} --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --profile ${PROFILE}
        else
            aws cloudformation deploy --stack-name ${STACKNAME} --template-file ${TEMPLATE} --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --profile ${PROFILE} --parameter-overrides ${OVERRIDELIST}
        fi
    ;;
    [g/G] )
        echo "get UPDATE_FAILED event..."
        aws cloudformation describe-stack-events --stack-name ${STACKNAME} --profile ${PROFILE} | grep "UPDATE_FAILED" | sed -n '1p'
    ;;
    [v/V] )
        echo "validation template..."
        aws cloudformation validate-template --profile ${PROFILE} --template-body file://${TEMPLATE}
    ;;
    [c/C] )
        echo "Cancel..."
        exit
    ;; 
esac