FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /src
COPY . ./
RUN cd /src/Api.Web.Tests && dotnet restore -s https://api.nuget.org/v3/index.json && \ 
    cd /src/Api.Web.Tests && dotnet build -c Release -o /app && \
    cd /src/Api.Account.RCL && dotnet build -c Release -o ./out

RUN apt-get update && \
 apt-get install -y libgdiplus libc6 libc6-dev && \
 apt-get install -y software-properties-common && \
 add-apt-repository 'deb http://deb.debian.org/debian sid main' && \
 apt-get install -y libicu-dev libharfbuzz0b libfontconfig1 libfreetype6 && \
 apt-get install -y libpango-1.0-0 && \
 apt-get install -y libpangocairo-1.0

#install fonts
RUN apt install -y fontconfig libicu-dev libharfbuzz0b libfontconfig1 libfreetype6 && \
 echo "deb http://deb.debian.org/debian stretch contrib" >> /etc/apt/sources.list && \
 apt-get update && \
 apt-get install -y ttf-mscorefonts-installer

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
WORKDIR /app
RUN useradd -r dnrun -u 3456 -d /app && chown -R dnrun /app && \
 sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/g' /etc/ssl/openssl.cnf
ENTRYPOINT ["dotnet", "test", "/app/Api.Web.Tests.dll"]