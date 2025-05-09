FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY AtbWeb.csproj ./
COPY AtbWeb.sln ./
COPY *.cs ./
COPY Properties/ ./Properties/
COPY Components/ ./Components/
COPY wwwroot/ ./wwwroot/
COPY appsettings*.json ./

RUN dotnet restore AtbWeb.sln

RUN dotnet publish AtbWeb.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "AtbWeb.dll"]