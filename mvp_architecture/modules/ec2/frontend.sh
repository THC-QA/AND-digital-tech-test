#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
chmod 644 /var/www/html/index.nginx-debian.html
cat > /var/www/html/index.nginx-debian.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>AND Digital Tech Test</title>
</head>
<style>
    div {
        width: 100%;
        height: 300px;
        display: flex;
        justify-content: center;
        align-items: center;
        background: #dddddd;
        }
</style>
<body>
        <div>
                <h1>This confirms the webpage has worked.</h1>
        </div>
        <div>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac vehicula purus, sit amet vestibulum augue. Curabitur tellus elit, dictum in egestas id, tristique eu ex.</p>
        </div>
</body>
</html>
EOF
systemctl enable nginx
systemctl start nginx