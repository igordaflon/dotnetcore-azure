# Start with the .NET SDK for building the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# Work within a folder named `/source`
WORKDIR /source

# Copy everything in this project and build app
COPY . ./dotnetcore-azure/
WORKDIR /source/dotnetcore-azure
RUN dotnet publish -c release -o /app 

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app ./

# Expose port 80
# This is important in order for the Azure App Service to pick up the app
ENV PORT 80
EXPOSE 80

# Start the app
ENTRYPOINT ["dotnet", "dotnetcoresample.dll"]