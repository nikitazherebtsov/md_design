import { InputElement } from "../elements/inputElement"
import * as t from "../parser/lexer"
import { IFormatter } from "./formFormatter"
import { FormFormatterFactory } from "./formatterFactory"
import { FormatterUtils } from "./formatterUtils"

export class InputFormatter implements IFormatter<InputElement> {
  public format(element: InputElement): string[] {
    const underline = t.Underscore.LABEL as string

    let header: string = FormatterUtils.getAlignmentAtLeft(element)

    header += element.properties.get("Заголовок") ?? ""
    header += t.Colon.LABEL + " "

    let value = ""
    if (element.value) {
      value = element.value
    }

    const modificators = this.getModificators(element)
    if (modificators.length > 0) {
      value += underline.repeat(2) + modificators
    }

    let excludeProperties = [
      "КнопкаВыпадающегоСписка",
      "КнопкаВыбора",
      "КнопкаОчистки",
      "КнопкаРегулирования",
      "КнопкаОткрытия",
      "ГоризонтальноеПоложениеВГруппе",
      "Заголовок",
    ]

    FormatterUtils.excludeStretchProperties(excludeProperties, element)

    if (this.isMultiline(element)) {
      excludeProperties.push("Высота")
      excludeProperties.push("МногострочныйРежим")
    }

    const propertiesFormatter = FormFormatterFactory.getPropertiesFormatter()
    const properties = propertiesFormatter.format(element, {
      excludeProperties: excludeProperties,
    })

    let result = header + value + properties.join("") + FormatterUtils.getAlignmentAtRight(element)

    result += this.getMultilineString(element, header.length, value.length)

    return [result]
  }

  private isMultiline(element: InputElement): boolean {
    const height = element.getProperty("Высота") as number
    return element.getProperty("МногострочныйРежим") === true && height > 1
  }

  private getMultilineString(element: InputElement, headerLength: number, valueLength: number): string {
    if (!this.isMultiline(element)) {
      return ""
    }

    const underline = t.Underscore.LABEL as string
    const height = element.getProperty("Высота") as number

    let multilineStringTemplate = "\n" + " ".repeat(headerLength) + underline.repeat(valueLength)
    let multilineString = multilineStringTemplate.repeat(height - 1)

    return multilineString
  }

  private getModificators(element: InputElement): string {
    const propertyMap: { [key: string]: string } = {
      КнопкаВыбора: "В",
      КнопкаВыпадающегоСписка: "С",
      КнопкаОчистки: "Х",
      КнопкаОткрытия: "О",
      КнопкаРегулирования: "Д",
    }

    return Object.keys(propertyMap)
      .filter((key) => element.properties.get(key) !== undefined)
      .map((key) => propertyMap[key])
      .join("")
  }
}
