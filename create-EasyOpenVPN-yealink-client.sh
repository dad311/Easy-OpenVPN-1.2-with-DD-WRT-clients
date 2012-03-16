echo "Please enter name for cert"
echo "Example: Yealink701"
read name
echo "Please enter your FQDN"
echo "Example: mypbx.homelinux.com OR 184.140.320.80"
read fqdn



cd /etc/openvpn/easy-rsa
source ./vars
./pkitool $name


rm /etc/openvpn/client.conf.tmp* > /dev/null

mkdir -p /root/keys/$name/keys

#create client.conf
echo "client" >>/etc/openvpn/client.conf.tmp
echo "dev tun" >>/etc/openvpn/client.conf.tmp
echo "proto udp" >>/etc/openvpn/client.conf.tmp
echo "remote $fqdn 1198" >>/etc/openvpn/client.conf.tmp
echo "resolv-retry infinite" >>/etc/openvpn/client.conf.tmp
echo "nobind" >>/etc/openvpn/client.conf.tmp
echo "persist-key" >>/etc/openvpn/client.conf.tmp
echo "persist-tun" >>/etc/openvpn/client.conf.tmp
echo "ca /yealink/config/openvpn/keys/ca.crt" >>/etc/openvpn/client.conf.tmp
echo "cert /yealink/config/openvpn/keys/$name.crt" >>/etc/openvpn/client.conf.tmp
echo "key /yealink/config/openvpn/keys/$name.key" >>/etc/openvpn/client.conf.tmp
echo "verb 3" >>/etc/openvpn/client.conf.tmp
echo "mute 10" >>/etc/openvpn/client.conf.tmp
echo "nobind" >>/etc/openvpn/client.conf.tmp

cp /etc/openvpn/ca.crt /root/keys/$name/keys
cp /etc/openvpn/easy-rsa/keys/$name.crt /root/keys/$name/keys
cp /etc/openvpn/easy-rsa/keys/$name.key /root/keys/$name/keys
cp /etc/openvpn/client.conf.tmp /root/keys/$name/$name.conf
mv /root/keys/$name/$name.conf /root/keys/$name/vpn.cnf
cd /root/keys/$name
tar cvf /root/keys/$name/$name.tar . > /dev/null 
echo "Yeahlink tar file file saved to /root/keys/$name"
echo "Copy the tar file to PC to be uploaded to Yealink phone"

