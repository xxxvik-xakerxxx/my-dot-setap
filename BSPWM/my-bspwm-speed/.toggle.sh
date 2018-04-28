read state < .toggle
if [ $state = "0" ]; then
  echo 1 > .toggle
else
  echo 0 > .toggle
fi
