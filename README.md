# Meli Busca - Processo seletivo Mercado Livre

<p align="center">
  <img src="./Media/exemplo_projeto.gif">
</p>

## Como rodar o projeto
Primeiro garanta que tem o XcodeGen instalado no seu Mac, para instruções de como instalar seguir o tutorial desse [link](https://github.com/yonaskolb/XcodeGen?tab=readme-ov-file#installing).

Esse projeto usa Swift 6.0, ou seja é necessário ter o Xcode 16 instalado na máquina caso esteja usando o Xcode 15 use a versão na branch `swift5-version` para conseguir rodar o projeto.

Com o XcodeGen instalado rode o seguinte comando:
```
xcodegen generate
```

Quando o projeto estiver gerado basta abrir o arquivo e rodar o target `App`

## Dependencias
### Dependencias de Build
 - [XcodeGen:](https://github.com/yonaskolb/XcodeGen)
    Usado para gerar automaticamente o projeto do XCode sem a necessidade do pbxproj ficar guardado no Git reduzindo os conflitos de Git
 - [SwiftGen:](https://github.com/SwiftGen/SwiftGen?tab=readme-ov-file)
    Usado para gerar arquivos de String e Cores para facilitar o uso dos mesmos
    OBS!: Devido a uma limitação do SwiftGen para Swift 6.0 é necessário marcar o `struct Colors` como `Sendable` já que o template atual não faz isso.
### Dependencias do Projeto
 - [SnapKit](https://github.com/SnapKit/SnapKit)
    Usado para facilitar a descrição de Constraints com ViewCode de forma mais simple

## Arquitetura e estrutura

## Pontos a melhorar
- CI/CD com Fastlane
- Sistema de injeção de dependencia usando [Swinject](https://github.com/Swinject/Swinject)
- Adicionar [SwiftLint](https://github.com/realm/SwiftLint) no Projeto
- Testes de Snapshot com [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing) para ViewControllers e Views
- Tokenização de Assets de imagens
