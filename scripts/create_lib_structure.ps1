$libPath = "D:\smart-hotel-ordering-system\mobile\customer_app\lib"

New-Item -ItemType Directory -Force -Path "$libPath\app\routes"
New-Item -ItemType Directory -Force -Path "$libPath\app\theme"
New-Item -ItemType Directory -Force -Path "$libPath\app\config"

New-Item -ItemType Directory -Force -Path "$libPath\core\constants"
New-Item -ItemType Directory -Force -Path "$libPath\core\errors"
New-Item -ItemType Directory -Force -Path "$libPath\core\exceptions"
New-Item -ItemType Directory -Force -Path "$libPath\core\network"
New-Item -ItemType Directory -Force -Path "$libPath\core\storage"
New-Item -ItemType Directory -Force -Path "$libPath\core\utils"
New-Item -ItemType Directory -Force -Path "$libPath\core\services"

New-Item -ItemType Directory -Force -Path "$libPath\shared\widgets"
New-Item -ItemType Directory -Force -Path "$libPath\shared\models"
New-Item -ItemType Directory -Force -Path "$libPath\shared\extensions"

$features = @("authentication","qr_scanner","hotel","menu","cart","order","payment","profile","table_session","queue","ratings","notifications")

foreach ($f in $features) {
    New-Item -ItemType Directory -Force -Path "$libPath\features\$f\data\datasources"
    New-Item -ItemType Directory -Force -Path "$libPath\features\$f\data\models"
    New-Item -ItemType Directory -Force -Path "$libPath\features\$f\data\repositories"
    New-Item -ItemType Directory -Force -Path "$libPath\features\$f\domain\entities"
    New-Item -ItemType Directory -Force -Path "$libPath\features\$f\domain\repositories"
    New-Item -ItemType Directory -Force -Path "$libPath\features\$f\domain\usecases"
    New-Item -ItemType Directory -Force -Path "$libPath\features\$f\presentation\controllers"
    New-Item -ItemType Directory -Force -Path "$libPath\features\$f\presentation\pages"
    New-Item -ItemType Directory -Force -Path "$libPath\features\$f\presentation\widgets"
}

Write-Host "Done. Folder structure created under $libPath"