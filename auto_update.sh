#!/bin/bash

time=`date +"%Y%m%d %H:%M:%S"`
content=""
update_content="Update time:"$time"  Update comment:"$content
git add *
git commit -m "update $update_content"
git push
