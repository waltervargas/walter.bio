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
echo $KEY >> $HOME/.ssh/authorized_keys
