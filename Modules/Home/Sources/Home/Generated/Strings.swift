// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// **Buscar**
  internal static let button = L10n.tr("Localizable", "Button", fallback: "**Buscar**")
  /// Digite abaixo o que deseja buscar!
  internal static let description = L10n.tr("Localizable", "Description", fallback: "Digite abaixo o que deseja buscar!")
  /// Localizable.strings
  ///   Home
  /// 
  ///   Created by Gabriel Ferreira de Carvalho on 07/02/25.
  internal static let name = L10n.tr("Localizable", "Name", fallback: "Meli Busca")
  /// Digite aqui o que deseja buscar
  internal static let placeholder = L10n.tr("Localizable", "Placeholder", fallback: "Digite aqui o que deseja buscar")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
