# App python AWS Runner

#Intruções

1- Realizar o fork do respositorio.

2- Realizar login via SSO com as Credencias da AWS.

3- Alterar os valores das secrets no Repositorio do Github

4- Alterar o codigo main.tf de acordo com o ambiente DEV ou PROD, e inicie o terraform para que seja criado as roles e um backend local.

5- Altere novamente o codigo de acordo com o ambiente e inicie novamente o Terraform para que seja migrado o state para nuvem.

6- Realize um Commit na branch dev para que seja executada a pipeline no ambiente de dev.

7- Realize um pull reequest na main para que seja executada a pipeline no ambiente de produção.
