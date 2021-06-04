#/bin/bash
echo "==============================================="
echo "Pode ser feito a migração abaixo? (S/N)"
echo "$1 >>>>> corrupto@mveloso.com.br"
echo "==============================================="
read confirmacao1
if  [ "${confirmacao1^}" != 'S' ];
    then
	echo "ABORTANDO!"
        exit;
fi
corrige_origem=`echo $1 | awk -F'@' '{print $2}'`;
host=`host mbox.$corrige_origem | awk -F'address' '{print $2}' | head -n 1`;
while [ -z "${confirmacao}" -o "${confirmacao^}" != 'N' ];
    do
        imapsync --host1 $host --user1 $1 --password1 'aq1sw2@#' --nossl1 --host2 mbox.mveloso.com.br --user2 corrupto@mveloso.com.br --password2 'aq1sw2@#' --nossl2 --addheader
        echo "=================================="
        echo "Deseja migrar mais uma vez? (S/N)"
        echo "$1 >>>>> corrupto@mveloso.com.br"
        echo "=================================="
        read confirmacao
    done
echo "==============================================="
echo "Pode ser feito a migração inversa agora? (S/N) "
echo "corrupto@mveloso.com.br >>>>> $1"
echo "==============================================="
read confirmacao2
if  [ "${confirmacao2^}" != 'S' ];
    then
        exit;
fi
while [ -z "${confirmacao2}" -o "${confirmacao2^}" != 'N' ];
    do
        imapsync --host1 mbox.mveloso.com.br --user1 corrupto@mveloso.com.br --password1 'aq1sw2@#' --delete1 --expunge1 --delete1emptyfolders --nossl1 --host2 $host --user2 $1 --password2 'aq1sw2@#' --nossl2 --addheader
        echo "=================================="
        echo "Deseja migrar mais uma vez? (S/N)"
        echo "corrupto@mveloso.com.br >>>>> $1"
        echo "=================================="
        read confirmacao2
    done
echo "============"
echo " Finalizado!"
echo "============"
exit;
