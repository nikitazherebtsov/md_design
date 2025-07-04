import { allTokens } from "@/parser/lexer"
import { Visitor } from "@/parser/visitor"
import { GroupVisitor } from "@/parser/groupVisitor"
import { Parser } from "@/parser/parser"
import { Lexer } from "chevrotain"
import { SemanticTokensManager } from "@/parser/visitorTools/sematicTokensManager"
import { IBuildResult } from "./interfaces"

export class CSTGenerator {
  private static readonly lexer = new Lexer(allTokens)
  private static readonly parser = new Parser()

  public static build(text: string, parseMethod: keyof Parser): IBuildResult {
    const semanticTokensManager = new SemanticTokensManager()

    const lexingResult = CSTGenerator.lexer.tokenize(text)

    CSTGenerator.parser.input = lexingResult.tokens

    const parseFunction = CSTGenerator.parser[parseMethod]
    if (typeof parseFunction !== "function") {
      throw new Error(`Parse method '${String(parseMethod)}' is not a function`)
    }

    const groupsAST = (CSTGenerator.parser as any)[parseMethod]()

    const groupVisitor = new GroupVisitor(CSTGenerator.parser)

    const fullAST = groupVisitor.visit(groupsAST)

    const visitor = new Visitor(semanticTokensManager)
    const result = visitor.visit(fullAST)

    return { element: result, semanticTokensManager: semanticTokensManager }
  }
}
