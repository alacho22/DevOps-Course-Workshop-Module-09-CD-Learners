FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

RUN apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash -
RUN apt-get install -y nodejs

COPY ./DotnetTemplate.Web /opt/dotnet/DotnetTemplate.Web
WORKDIR /opt/dotnet/DotnetTemplate.Web
RUN dotnet publish -c Release -o /opt/dotnet/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /opt/app
COPY --from=build /opt/dotnet/out /opt/app/
ENTRYPOINT ["dotnet", "./DotnetTemplate.Web.dll"]