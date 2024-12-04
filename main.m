#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <CoreFoundation/CoreFoundation.h>
#include <MobileGestalt/MobileGestalt.h>

#define kMGDeviceName CFSTR("DeviceName")
#define kMGBuildVersion CFSTR("BuildVersion")
#define kMGProductType CFSTR("ProductType")
#define kMGSerialNumber CFSTR("SerialNumber")
#define kMGWifiAddress CFSTR("WifiAddress")
#define kMGBluetoothAddress CFSTR("BluetoothAddress")
#define kMGProductVersion CFSTR("ProductVersion")
#define kMGUniqueDeviceID CFSTR("UniqueDeviceID")
#define kMGRegionCode CFSTR("RegionCode")

typedef struct {
    const char *attribute;
    CFStringRef key;
} MGAttribute;

MGAttribute attributes[] = {
    {"DEVICE_NAME", kMGDeviceName},
    {"VERSION", kMGBuildVersion},
    {"PRODUCT", kMGProductType},
    {"SERIAL_NUMBER", kMGSerialNumber},
    {"WIFI_ADDRESS", kMGWifiAddress},
    {"BLUETOOTH_ADDRESS", kMGBluetoothAddress},
    {"SOFTWARE_VERSION", kMGProductVersion},
    {"UNIQUE_DEVICE_ID", kMGUniqueDeviceID},
    {"REGION_CODE", kMGRegionCode}
};

void MGSendRequest(MGAttribute attributes[], size_t numAttributes) {
    printf("\n=== DEVICE INFORMATION ===\n");
    for (size_t i = 0; i < numAttributes; i++) {
        CFStringRef result = MGCopyAnswer(attributes[i].key, NULL);
        
        if (result != NULL) {
            char buffer[1024];
            const char *resultStr = CFStringGetCString(result, buffer, sizeof(buffer), kCFStringEncodingUTF8) ? buffer : NULL;

            if (resultStr != NULL) {
                printf("%-20s: %s\n", attributes[i].attribute, resultStr);
            } else {
                printf("%-20s: [Unable to convert data]\n", attributes[i].attribute);
            }

            CFRelease(result);
        } else {
            printf("%-20s: [Unable to retrieve data]\n", attributes[i].attribute);
        }
    }
    printf("=============================\n");
}

int main(int argc, char **argv) {
    size_t numAttributes = sizeof(attributes) / sizeof(attributes[0]);
    MGSendRequest(attributes, numAttributes);
    return 0;
}
