# Собирается scripts/release.sh из packaging/homebrew/meetnote.rb.in — руками не править.
cask "meetnote" do
  version "1.3.7"
  sha256 "75f1c1509c556c80d41f74133491f9f9af570c03a88df0a4d21f4138a777a597"

  url "https://github.com/dikdacksun/homebrew-meetnote/releases/download/v#{version}/MeetNote-#{version}.zip"
  name "MeetNote"
  desc "Конспекты встреч на этом Mac: запись, расшифровка, конспект, чаты по встречам"
  homepage "https://github.com/dikdacksun/homebrew-meetnote"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "MeetNote.app"

  # Приложение подписано сертификатом Apple Development, без нотаризации: снимаем карантин, иначе macOS не откроет его.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/MeetNote.app"]
  end

  uninstall quit: "local.telemostnotes.app"

  # Встречи, расшифровки и модели не удаляются даже при zap — только если удалить их вручную.

  caveats <<~EOS
    Откройте MeetNote — окно «Установка моделей MeetNote» откроется само: проверит этот Mac,
    подберёт модель и скачает её (от 13 до 27 ГБ, один раз). Дальше MeetNote работает без интернета.

    О новой версии MeetNote скажет сам — кнопка «Обновить» (или brew upgrade --cask meetnote).
    Нужны Apple Silicon, macOS 26 и не меньше 16 ГБ памяти.
  EOS
end
