#! /bin/bash

# ---- configure login & ssh ----
echo "root:${LOGIN_PASSWORD}" | chpasswd
# below line will create ~/.ssh
# ssh-keygen -q -t rsa -N '' <<< ""$'\n'"y" 2>&1 >/dev/null
cp -r /src/configs/ssh ~/.ssh
# ---- end ----