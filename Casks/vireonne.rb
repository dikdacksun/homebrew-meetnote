# Собирается scripts/release.sh из packaging/homebrew/vireonne.rb.in — руками не править.
cask "vireonne" do
  version "1.5.1"
  sha256 "a12b0ec91741ed6a78e25d755daffb903175a9259d8521589ce5ffd4a7fc54dc"

  url "https://github.com/dikdacksun/homebrew-vireonne/releases/download/v#{version}/Vireonne-#{version}.zip"
  name "Vireonne"
  desc "Конспекты встреч на этом Mac: запись, расшифровка, конспект, чаты по встречам"
  homepage "https://github.com/dikdacksun/homebrew-vireonne"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "Vireonne.app"

  # Приложение подписано сертификатом Apple Development, без нотаризации: снимаем карантин, иначе macOS не откроет его.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Vireonne.app"]
  end

  uninstall quit: "local.telemostnotes.app"

  # Встречи, расшифровки и модели не удаляются даже при zap — только если удалить их вручную.

  caveats <<~EOS
    Откройте Vireonne — окно «Установка моделей Vireonne» откроется само: проверит этот Mac,
    подберёт модель и скачает её (от 13 до 27 ГБ, один раз). Дальше Vireonne работает без интернета.

    О новой версии Vireonne скажет сам — кнопка «Обновить» (или brew upgrade --cask vireonne).
    Нужны Apple Silicon, macOS 26 и не меньше 16 ГБ памяти.
  EOS
end
