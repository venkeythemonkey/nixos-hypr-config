{ pkgs, ... }:

{
  # Enable hardware OpenGL / Vulkan rendering.
  # Required for Wayland compositors, VA-API, and 32-bit game support.
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      # Intel iHD VA-API driver — enables hardware video decode/encode for
      # H.264, H.265/HEVC, VP8, VP9, AV1 on Raptor Lake-P (i915 + HuC).
      intel-media-driver

      # Mesa-based VAAPI backend (fallback for older Intel GPUs via Iris).
      mesa.drivers

      # VA-API over Vulkan bridge — lets Vulkan-capable apps use VA-API.
      libvdpau-va-gl

      # Intel media SDK / oneVPL for hardware video processing.
      intel-media-sdk
    ];
  };

  # VA-API: tell apps to use the iHD driver (Broadwell and newer).
  # i965 is the legacy driver for older GPUs — not needed on Core 7 240H.
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  environment.systemPackages = with pkgs; [
    # Codec libraries & utilities
    ffmpeg                             # CLI video/audio encoding & transcoding
    mpv                                # Hardware-accelerated media player
    libva-utils                        # vainfo — verify VA-API is working

    # GStreamer plugin bundles
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good        # VP8, FLAC, JPEG, Matroska, ...
    gst_all_1.gst-plugins-bad         # HLS, MPEG-TS, WebRTC, ...
    gst_all_1.gst-plugins-ugly        # H.264, MPEG-2, MP3 (patent-encumbered)
    gst_all_1.gst-libav               # FFmpeg-backed decoders (broadest coverage)
    gst_all_1.gst-vaapi               # VA-API hardware decode in GStreamer pipeline

    # USB inspection tool
    usbutils                           # lsusb
  ];
}
