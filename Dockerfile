FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# copy csproj and restore as distinct layers
COPY ["MyWebApi.csproj", "./"]
RUN dotnet restore "MyWebApi.csproj"

# copy everything else and build
COPY . .
RUN dotnet publish "MyWebApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# Render provides PORT; bind Kestrel to it
ENV ASPNETCORE_URLS=http://0.0.0.0:${PORT}

COPY --from=build /app/publish .

# Render expects the service to listen on $PORT; 8080 is a common default for local runs
EXPOSE 8080

ENTRYPOINT ["dotnet", "MyWebApi.dll"]
