# Minimal static file server for local preview (dev only).
# Usage: pwsh -File .\serve.ps1 -Root . -Port 8790
param(
    [string]$Root = (Get-Location).Path,
    [int]$Port = 8790
)

$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://127.0.0.1:$Port/")
$listener.Start()
Write-Host "Serving $Root at http://127.0.0.1:$Port/"

$types = @{
    '.html' = 'text/html; charset=utf-8'
    '.json' = 'application/json; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.md'   = 'text/plain; charset=utf-8'
    '.png'  = 'image/png'
}

while ($listener.IsListening) {
    try {
        $ctx = $listener.GetContext()
        $rel = $ctx.Request.Url.LocalPath.TrimStart('/')
        if ([string]::IsNullOrWhiteSpace($rel)) { $rel = 'index.html' }
        $path = Join-Path $Root $rel

        if (Test-Path -LiteralPath $path -PathType Leaf) {
            $bytes = [System.IO.File]::ReadAllBytes($path)
            $ext = [System.IO.Path]::GetExtension($path).ToLower()
            $ctx.Response.ContentType = if ($types.ContainsKey($ext)) { $types[$ext] } else { 'application/octet-stream' }
            $ctx.Response.ContentLength64 = $bytes.Length
            $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
        }
        else {
            $ctx.Response.StatusCode = 404
            $msg = [System.Text.Encoding]::UTF8.GetBytes('Not found')
            $ctx.Response.OutputStream.Write($msg, 0, $msg.Length)
        }
        $ctx.Response.Close()
    }
    catch { }
}
