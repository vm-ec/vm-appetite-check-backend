# Use the official .NET SDK image as the build image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory inside the container
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["vm-appetite-check-backend.csproj", "./"]

# Restore dependencies
RUN dotnet restore

# Copy the rest of the source code
COPY . .

# Publish the application to the /publish directory inside the container
RUN dotnet publish "vm-appetite-check-backend.csproj" -c Release -o /publish

# Use the official .NET runtime image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base

# Set the working directory inside the container for the final image
WORKDIR /app

# Copy the published output from the build stage into the container
COPY --from=build /publish .

# Expose the application on port 5131
EXPOSE 5131

# Set the entry point for the application
ENTRYPOINT ["dotnet", "vm-appetite-check-backend.dll"]
