sourceanalyzer -b "BuildID2" –clean
sourceanalyzer -b "BuildID2" –Xmx2G -Xss8M xcodebuild -project mHealth.xcodeproj -sdk iphonesimulator
sourceanalyzer -b "BuildID2" –Xmx2G -Xss8M -scan -f HealthReachScanResult.fpr
sourceanalyzer -b "BuildID2" –clean
