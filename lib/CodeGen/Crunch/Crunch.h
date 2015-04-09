#ifndef LLVM_CLANG_LIB_CODEGEN_CRUNCH_CRUNCH_H
#define LLVM_CLANG_LIB_CODEGEN_CRUNCH_CRUNCH_H

#include "CodeGenFunction.h"
#include "CodeGenModule.h"
#include <cstring>

namespace Crunch {

enum CheckFunctionKind : unsigned int;

void emitCastCheck(clang::CodeGen::CodeGenFunction &CGF, clang::Expr *ClangSrc,
                   llvm::Value *Src, clang::QualType &DestClangTy);

llvm::Value *markSizeofExpr(clang::CodeGen::CodeGenFunction &CGF,
                            const clang::UnaryExprOrTypeTraitExpr *E,
                            llvm::Value *actualValue);

std::string parseType(const clang::QualType &,
                      CheckFunctionKind *, int *);

std::string getUniqtypeName(const clang::QualType &);

} // namespace Crunch

#endif
