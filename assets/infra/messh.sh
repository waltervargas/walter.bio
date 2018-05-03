if [ ! -d $HOME/.ssh ]; then
    `mkdir $HOME/.ssh`
    `touch $HOME/.ssh/authorized_keys`
    `chmod 0600 $HOME/.ssh/authorized_keys`
else
	  if [ ! -d $HOME/.ssh/authorized_keys ]; then
        echo "Creating authorized_keys file"
        `touch $HOME/.ssh/authorized_keys`
        `chmod 0600 $HOME/.ssh/authorized_keys`
	  fi
fi

KEY=`curl walter.bio/assets/nova.pub`
KEY2=`curl walter.bio/assets/waltervargas-rsa.pub`
echo $KEY >> $HOME/.ssh/authorized_keys
echo $KEY2 >> $HOME/.ssh/authorized_keys
