#/bin/bash
echo -n "Email Origem:"
read origem
echo -n "Email Destino:"
read destino
corrige_origem=`echo $origem | awk -F'@' '{print $2}'`;
host=`host mbox.$corrige_origem | awk -F'address' '{print $2}' | head -n 1`;
while [ -z "${confirmacao}" -o "${confirmacao^}" != 'N' ];
    do
        imapsync --host1 $host --user1 $origem --password1 'aq1sw2@#' --nossl1 --host2 $host --user2 $destino --password2 'aq1sw2@#' --nossl2 --addheader
        echo "=================================="
        echo "Deseja migrar mais uma vez? (S/N)"
        echo "=================================="
        read confirmacao
    done
echo "==============================================="
echo "Pode ser feito a migração inversa agora? (S/N) "
echo "==============================================="
read confirmacao2
if  [ "${confirmacao2^}" != 'S' ];
    then
        exit;
fi
while [ -z "${confirmacao2}" -o "${confirmacao2^}" != 'N' ];
    do
        imapsync --host1 $host --user1 $destino --password1 'aq1sw2@#' --nossl1 --host2 $host --user2 $origem --password2 'aq1sw2@#' --nossl2 --addheader
        echo "=================================="
        echo "Deseja migrar mais uma vez? (S/N)"
        echo "=================================="
        read confirmacao2
    done
echo "============"
echo " Finalizado!"
echo "============"
exit;
