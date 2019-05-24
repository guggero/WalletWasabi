FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

COPY . /app/

WORKDIR /app/WalletWasabi.Backend
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/WalletWasabi.Backend/out .
ENTRYPOINT ["dotnet", "WalletWasabi.Backend.dll"]
