#!/bin/bash

REGION=$1
STACK_NAME=$2

aws cloudformation deploy \
--template-file infrastructure/ecs.yml \
--region $REGION \
--stack-name $STACK_NAME \
--capabilities CAPABILITY_NAMED_IAM
