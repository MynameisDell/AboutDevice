#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <CoreFoundation/CoreFoundation.h>
#include <MobileGestalt/MobileGestalt.h>

#define kMGBuildVersion CFSTR("BuildVersion")
#define kMGProductType CFSTR("ProductType")
#define kMGSerialNumber CFSTR("SerialNumber")
#define kMGWifiAddress CFSTR("WifiAddress")
#define kMGBluetoothAddress CFSTR("BluetoothAddress")
#define kMGProductVersion CFSTR("ProductVersion")

typedef struct {
    const char *attribute;
    CFStringRef key;
} MGAttribute;

MGAttribute MGAttributeVersion = {"VERSION", kMGBuildVersion};
MGAttribute MGAttributeProduct = {"PRODUCT", kMGProductType};
MGAttribute MGAttributeSerialNumber = {"SERIAL_NUMBER", kMGSerialNumber};
MGAttribute MGAttributeWifiAddress = {"WIFI_ADDRESS", kMGWifiAddress};
MGAttribute MGAttributeBluetoothAddress = {"BLUETOOTH_ADDRESS", kMGBluetoothAddress};
MGAttribute MGAttributeSoftwareVersion = {"SOFTWARE_VERSION", kMGProductVersion};

void MGSendRequest(MGAttribute attributes[], size_t numAttributes) {
    for (size_t i = 0; i < numAttributes; i++) {
        CFStringRef result = MGCopyAnswer(attributes[i].key, NULL);
        
        if (result != NULL) {
            const char *resultStr = CFStringGetCStringPtr(result, kCFStringEncodingUTF8);
            if (resultStr == NULL) {
                char buffer[1024];
                if (CFStringGetCString(result, buffer, sizeof(buffer), kCFStringEncodingUTF8)) {
                    resultStr = buffer;
                }
            }
            if (resultStr != NULL) {
                printf("%s: %s\n", attributes[i].attribute, resultStr);
            }

            CFRelease(result);
        } else {
            printf("%s: Không thể lấy dữ liệu\n", attributes[i].attribute);
        }
    }
}

int main(int argc, char **argv) {
    MGAttribute attributes[] = {
        MGAttributeVersion,
        MGAttributeProduct,
        MGAttributeSerialNumber,
        MGAttributeWifiAddress,
        MGAttributeBluetoothAddress,
        MGAttributeSoftwareVersion
    };

    MGSendRequest(attributes, sizeof(attributes) / sizeof(attributes[0]));

    return 0;
}
