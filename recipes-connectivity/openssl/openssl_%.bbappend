# The legacy provider supplies MD4 and DES, which wpa_supplicant requires for
# EAP-MSCHAPv2 (WPA-Enterprise). Since OpenSSL 3.5.x it is opt-in.
PACKAGECONFIG:append = " legacy"
