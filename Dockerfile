# Use the official .NET SDK image as the build image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory inside the container
WORKDIR /src

# Copy the project files to the container
COPY ["vm-appetite-check-backend.csproj", "./"]

# Restore the dependencies (restore only the project file)
RUN dotnet restore "vm-appetite-check-backend.csproj"

# Copy the remaining source code
COPY . .

# Publish the application to the /app directory in the container
RUN dotnet publish "vm-appetite-check-backend.csproj" -c Release -o /app

# Use the official .NET runtime image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base

# Set the working directory in the container
WORKDIR /app

# Copy the published files from the build stage to the final image
COPY --from=build /app

# Expose the application port (changed to 5131 as per your requirement)
EXPOSE 5131

# Set the entry point to the application
ENTRYPOINT ["dotnet", "vm-appetite-check-backend.dll"]
