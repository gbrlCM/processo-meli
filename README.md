# Meli Busca - Processo seletivo Mercado Livre

<p align="center">
  <img src="./Media/exemplo_projeto.gif">
</p>

## Dependencias
### Dependencias de Build
 - [XcodeGen](https://github.com/yonaskolb/XcodeGen)
    Usado para gerar automaticamente o projeto do XCode sem a necessidade do pbxproj ficar guardado no Git reduzindo os conflitos de Git
 - [SwiftGen](https://github.com/SwiftGen/SwiftGen?tab=readme-ov-file)
    Usado para gerar arquivos de String e Cores para facilitar o uso dos mesmos
    OBS!: Devido a uma limitação do SwiftGen para Swift 6.0 é necessário marcar o `struct Colors` como `Sendable` já que o template atual não faz isso.
### Dependencias do Projeto
 - [SnapKit](https://github.com/SnapKit/SnapKit)
    Usado para facilitar a descrição de Constraints com ViewCode de forma mais simple

## Arquitetura e estrutura

## Pontos a melhorar
