mkdir $1

cp template/server.properties $1
cp template/ops.json $1
mkdir $1/config
cp template/config/FabricProxy-Lite.toml $1/config

cd $1
touch eula.txt && echo "eula=true" > eula.txt

wget -O loader https://meta.fabricmc.net/v2/versions/loader/
wget -O installer https://meta.fabricmc.net/v2/versions/installer
wget -O server.jar https://meta.fabricmc.net/v2/versions/loader/$2/$(jq -r '.[0].version' loader)/$(jq -r '.[0].version' installer)/server/jar
rm loader installer

ferium profile create --game-version $2 --mod-loader fabric --name $1 --output-dir $(pwd)/mods
ferium add fabric-api
ferium add spark
ferium add fabricproxy-lite
ferium add lithium-fabric
ferium add servux-fabric
ferium add starlight
ferium add fabric-carpet

ferium upgrade


