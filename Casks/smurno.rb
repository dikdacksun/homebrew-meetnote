# Собирается scripts/release.sh из packaging/homebrew/smurno.rb.in — руками не править.
cask "smurno" do
  version "1.5.4"
  sha256 "b7a5554a674003b82c11e3ec6662b1fcef3b204528cae26d0d663b225af0a963"

  url "https://github.com/dikdacksun/homebrew-smurno/releases/download/v#{version}/Smurno-#{version}.zip"
  name "Smurno"
  desc "Конспекты встреч на этом Mac: запись, расшифровка, конспект, чаты по встречам"
  homepage "https://github.com/dikdacksun/homebrew-smurno"

  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "Smurno.app"

  # Приложение подписано сертификатом Apple Development, без нотаризации: снимаем карантин, иначе macOS не откроет его.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Smurno.app"]
  end

  uninstall quit: "local.telemostnotes.app"

  # Встречи, расшифровки и модели не удаляются даже при zap — только если удалить их вручную.

  caveats <<~EOS
    Откройте Smurno — окно «Установка моделей Smurno» откроется само: проверит этот Mac,
    подберёт модель и скачает её (от 13 до 27 ГБ, один раз). Дальше Smurno работает без интернета.

    О новой версии Smurno скажет сам — кнопка «Обновить» (или brew upgrade --cask smurno).
    Нужны Apple Silicon и macOS 26. Для конспекта на этом Mac — от 16 ГБ памяти; с меньшей памятью конспект пишет внешняя модель (Claude или ChatGPT).
  EOS
end
