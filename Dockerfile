FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app
COPY "SampleWebApp.csproj" .
RUN dotnet restore SampleWebApp.csproj

COPY . .

FROM build as publish
RUN dotnet publish "SampleWebApp.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS final-stage
WORKDIR /app
COPY --from=publish /app/publish .

ENV ASPNETCORE_URLS=http://0.0.0.0:5000
EXPOSE 5000

ENTRYPOINT [ "dotnet", "SampleWebApp.dll" ]