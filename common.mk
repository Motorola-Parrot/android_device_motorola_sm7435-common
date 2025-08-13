#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.0-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl \
    android.hardware.soundtrigger@2.3-impl \
    audioadsprpcd \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.primary.parrot \
    audio.usb.default \
    lib_bt_aptx \
    lib_bt_ble \
    lib_bt_bundle \
    libagmmixer \
    libagmclient \
    libagm_compress_plugin \
    libagm_mixer_plugin \
    libagm_pcm_plugin \
    libfmpal \
    libpalclient \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    sound_trigger.primary.parrot \
    vendor.qti.hardware.AGMIPC@1.0-service

PRODUCT_COPY_FILES += \
    hardware/qcom-caf/sm8450/audio/primary-hal/configs/common/codec2/media_codecs_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2_audio.xml \
    hardware/qcom-caf/sm8450/audio/primary-hal/configs/common/codec2/service/1.0/c2audio.vendor.base-arm64.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/c2audio.vendor.base-arm64.policy \
    hardware/qcom-caf/sm8450/audio/primary-hal/configs/common/codec2/service/1.0/c2audio.vendor.ext-arm64.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/c2audio.vendor.ext-arm64.policy \
    hardware/qcom-caf/sm8450/audio/primary-hal/configs/parrot/card-defs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/card-defs.xml \
    hardware/qcom-caf/sm8450/audio/primary-hal/configs/parrot/microphone_characteristics.xml:$(TARGET_COPY_OUT_VENDOR)/etc/microphone_characteristics.xml

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_parrot/audio_effects.xml \
    $(LOCAL_PATH)/configs/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio-impl

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery

$(call soong_config_set, ufsbsg, ufsframework, bsg)

# Camera
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.concurrent.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.concurrent.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

# Charger
WITH_LINEAGE_CHARGER := false

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@4.0-impl-qti-display \
    init.qti.display_boot.rc \
    init.qti.display_boot.sh \
    gralloc.default \
    vendor.qti.hardware.display.allocator-service \
    vendor.qti.hardware.display.composer-service \
    vendor.qti.hardware.display.demura-service

PRODUCT_COPY_FILES += \
    hardware/qcom-caf/sm8450/display/config/snapdragon_color_libs_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/snapdragon_color_libs_config.xml

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# Fastboot
PRODUCT_PACKAGES += \
    fastbootd

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1-impl-qti \
    android.hardware.gnss-aidl-impl-qti \
    android.hardware.gnss-aidl-service-qti

PRODUCT_PACKAGES += \
    libbatching \
    libgeofencing \
    libgnss

PRODUCT_PACKAGES += \
    apdr.conf \
    batching.conf \
    gnss_antenna_info.conf \
    gps.conf \
    izat.conf \
    lowi.conf \
    sap.conf

PRODUCT_PACKAGES += \
    gnss@2.0-base.policy \
    gnss@2.0-xtra-daemon.policy

$(call soong_config_set, qtilocation, feature_nhz, false)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml

# Graphics
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.health-service.qti_recovery

# Hotword Enrollement
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/product_privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sysconfig/hotword-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/hotword-hiddenapi-package-whitelist.xml

# Init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom.zram:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom.zram \
    $(LOCAL_PATH)/rootdir/etc/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc

$(foreach f,$(filter-out $(if $(TARGET_USES_ST_NFC),,$(LOCAL_PATH)/rootdir/etc/init/hw/init.vendor.st21nfc.rc),$(wildcard $(LOCAL_PATH)/rootdir/etc/init/hw/*.rc)),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/$(notdir $f)))
$(foreach f,$(wildcard $(LOCAL_PATH)/rootdir/etc/init/*.rc),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/$(notdir $f)))
$(foreach f,$(wildcard $(LOCAL_PATH)/rootdir/bin/*.sh),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/bin/$(notdir $f)))

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:recovery/root/init.recovery.qcom.rc

# IPACM
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml \
    IPACM_Filter_cfg.xml

# Keymaster
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml

# Network
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.ipsec_tunnel_migration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnel_migration.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    Tag

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml

ifeq ($(TARGET_USES_NXP_NFC),true)
  PRODUCT_PACKAGES += \
      android.hardware.nfc-service.nxp \
      nqnfcinfo
endif
ifeq ($(TARGET_USES_ST_NFC),true)
  PRODUCT_PACKAGES += \
      android.hardware.nfc-service.st
  PRODUCT_SYSTEM_PROPERTIES += \
    persist.nfc_cfg.config_file_name=libnfc-nci-st.conf
  PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.nfc.st.multisim_fw_config=true
endif

# Native libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt \
    $(LOCAL_PATH)/configs/public.libraries-qti.txt:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/public.libraries-qti.txt

# Overlay
PRODUCT_ENFORCE_RRO_TARGETS := *

DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    FrameworksResCommon \
    SettingsCommon \
    SystemUIResCommon \
    TelephonyResCommon \
    WifiResCommon \
    FrameworksResTarget \
    WifiResTarget

PRODUCT_PACKAGES += \
    NcmTetheringOverlay

# Mountpoints
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    vendor_bt_firmware_mountpoint \
    vendor_dsp_mountpoint \
    vendor_firmware_mnt_mountpoint \
    vendor_fsg_mountpoint \
    vendor_super_fsg_mountpoint \
    vendor_super_modem_mountpoint

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service-qti

# RFS MSM MPSS symlinks
PRODUCT_PACKAGES += \
    rfs_msm_mpss_readonly_vendor_fsg_symlink

# Secure Element
ifeq ($(TARGET_USES_ST_NFC),true)
  PRODUCT_PACKAGES += \
      android.hardware.secure_element@1.2-service-gto
endif

# Security
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.biometrics.face.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.multihal \
    sensors.moto_sm7435

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf \

$(foreach sku, parrot ravelin, \
    $(eval PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(sku)/android.hardware.sensor.accelerometer.xml \
        frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(sku)/android.hardware.sensor.barometer.xml \
        frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(sku)/android.hardware.sensor.compass.xml \
        frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(sku)/android.hardware.sensor.gyroscope.xml \
        frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(sku)/android.hardware.sensor.light.xml \
        frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(sku)/android.hardware.sensor.proximity.xml \
        frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(sku)/android.hardware.sensor.stepcounter.xml \
        frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_$(sku)/android.hardware.sensor.stepdetector.xml \
    ))
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_parrot/android.hardware.sensor.hifi_sensors.xml \


# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/motorola

# Telephony
PRODUCT_PACKAGES += \
    extphonelib \
    extphonelib-product \
    extphonelib.xml \
    extphonelib_product.xml \
    MotoNrEnabler \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    qti-telephony-utils-prd \
    qti_telephony_utils_prd.xml \
    telephony-ext

PRODUCT_PACKAGES += \
    qcrilNrDb_vendor

PRODUCT_BOOT_JARS += \
    telephony-ext

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/telephony_system-ext_privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/telephony_system-ext_privapp-permissions-qti.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.qti

# Multitouch
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti \
    android.hardware.usb.gadget-service.qti \
    init.qcom.usb.rc \
    init.qcom.usb.sh \
    usb_compositions.conf


PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/usb/etc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# Vendor service manager
PRODUCT_PACKAGES += \
    vndservicemanager

# Verified boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

PRODUCT_COPY_FILES += \
    vendor/qcom/opensource/vibrator/excluded-input-devices.xml:$(TARGET_COPY_OUT_VENDOR)/etc/excluded-input-devices.xml

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    libwifi-hal-qcom \
    wpa_supplicant \
    wpa_supplicant.conf

# WiFi firmware symlinks
$(foreach variant,$(TARGET_WIFI_VARIANTS), \
    $(eval PRODUCT_PACKAGES += \
        firmware_$(variant)_wlan_mac.bin_symlink \
        firmware_$(variant)_WCNSS_qcom_cfg.ini_symlink) \
)

# WiFi config files
$(foreach variant,$(TARGET_WIFI_VARIANTS), \
    $(eval PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/configs/wifi/$(variant)/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/$(variant)/WCNSS_qcom_cfg.ini) \
)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/configs/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.rtt.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml

PRODUCT_VENDOR_MOVE_ENABLED := true

# Inherit from vendor blobs
$(call inherit-product, vendor/motorola/sm7435-common/sm7435-common-vendor.mk)
