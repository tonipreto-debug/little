$path = 'c:\Users\tonip\Desktop\LITTLE\css\style.css'
$content = Get-Content $path -Encoding UTF8
# Lines 2542-2607 (0-indexed 2541-2606)
$head = $content[0..2540]
$tail = $content[2607..($content.Length - 1)]

$new = @"
/* Timeline Responsiveness */
@media (max-width: 935px) {

    /* Text block: always take full width, no absolute positioning */
    .timeline-content {
        width: 100% !important;
        margin-left: 0 !important;
        margin-right: 0 !important;
        border-right: none !important;
        border-left: 5px solid var(--color-accent-primary) !important;
    }

    .timeline-item, .timeline-item:nth-child(even) {
        flex-direction: column !important;
        padding: 0 20px 0 60px !important;
        align-items: flex-start !important;
        min-height: auto !important;
    }

    /* Images and videos: sit in normal document flow BELOW text */
    .timeline-img-box, .vertical-reel,
    #vertical-reel-video, #vertical-reel-image {
        position: relative !important;
        top: auto !important; right: auto !important;
        left: auto !important; bottom: auto !important;
        display: block !important;
        width: 100% !important;
        max-width: 85vw !important;
        height: 110vw !important;
        max-height: 520px !important;
        min-width: 0 !important;
        min-height: 0 !important;
        margin: 20px auto 50px auto !important;
        /* Start hidden - JS will reveal */
        opacity: 0 !important;
        transform: translateY(60px) scale(0.93) !important;
        transition: none !important;
        border: 6px solid white !important;
        border-radius: 20px !important;
        box-shadow: 0 18px 40px rgba(0,0,0,0.18) !important;
        overflow: hidden !important;
    }

    /* Revealed state triggered by JS */
    .timeline-img-box.mob-img-show,
    .vertical-reel.mob-img-show,
    #vertical-reel-video.mob-img-show,
    #vertical-reel-image.mob-img-show {
        animation: mobImgReveal 0.9s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards !important;
    }

    @keyframes mobImgReveal {
        0%   { opacity: 0; transform: translateY(60px) scale(0.93) !important; }
        100% { opacity: 1; transform: translateY(0) scale(1) !important; }
    }

    /* Images & video always fill their box */
    .timeline-img-box img, .timeline-img-box video,
    .vertical-reel img, .vertical-reel video {
        width: 100% !important;
        height: 100% !important;
        object-fit: cover !important;
    }
}

/* Responsive Timeline */
@media (max-width: 768px) {
    .timeline-wrapper::before {
        left: 30px;
    }
    .timeline-item, .timeline-item:nth-child(even) {
        justify-content: flex-start;
        padding-left: 60px;
        padding-right: 15px;
    }
    .timeline-icon {
        left: 10px;
    }
    .timeline-item:nth-child(odd) .timeline-content,
    .timeline-item:nth-child(even) .timeline-content {
        width: 100%;
        margin-left: 0;
        margin-right: 0;
        border-right: none;
        border-left: 5px solid var(--color-accent-primary);
    }
}
"@ -split "`n" | ForEach-Object { $_.TrimEnd() }

$final = $head + $new + $tail
[IO.File]::WriteAllLines($path, $final, (New-Object System.Text.UTF8Encoding($false)))
Write-Output "CSS updated!"
