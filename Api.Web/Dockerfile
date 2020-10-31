FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /src
COPY . ./
RUN cd /src/api/Api.Web.Tests && dotnet restore -s https://api.nuget.org/v3/index.json
RUN cd /src/api/Api.Web.Tests && dotnet build -c Release -o /app

#RUN cd /src/api/Api.Account.RCL && dotnet build -c Release -o ./out
#RUN  mkdir -p /app/compiledModules && cp -f /src/api/Api.Account.RCL/out/*.dll  /app/compiledModules/

#RUN cd /src/api/Api.Integration.RCL && dotnet build -c Release -o ./out
#RUN  mkdir -p /app/compiledModules && cp -f /src/api/Api.Integration.RCL/out/*.dll  /app/compiledModules/

RUN rm -vf /app/configs/ConnectionStrings.json

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
RUN apt-get update  
RUN apt-get update && apt-get install -y libgdiplus libc6 libc6-dev
RUN apt-get install -y software-properties-common  
RUN add-apt-repository 'deb http://deb.debian.org/debian sid main'  
RUN apt-get install -y libicu-dev libharfbuzz0b libfontconfig1 libfreetype6 libc6-dev
RUN apt-get install -y libpango-1.0-0
RUN apt-get install -y libpangocairo-1.0

#install fonts
RUN apt install -y fontconfig libicu-dev libharfbuzz0b libfontconfig1 libfreetype6
RUN echo "deb http://deb.debian.org/debian stretch contrib" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y ttf-mscorefonts-installer

FROM mcr.microsoft.com/dotnet/core/sdk:3.1
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
WORKDIR /app
COPY --from=build-env /app .
RUN useradd -r dnrun -u 3456 -d /app && chown -R dnrun /app
RUN sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/g' /etc/ssl/openssl.cnf
ENTRYPOINT ["dotnet", "test", "/app/Api.Web.Tests.dll"]