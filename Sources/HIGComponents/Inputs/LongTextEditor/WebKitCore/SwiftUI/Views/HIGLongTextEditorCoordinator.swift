//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

import SwiftUI

public final class HIGLongTextEditorCoordinator: HIGLongTextEditorViewDelegate {
    private let parent: HIGLongTextEditorRepresentable

    init(parent: HIGLongTextEditorRepresentable) {
        self.parent = parent
    }

    public func higLongTextEditorViewDidLoad(_ higLongTextEditorView: HIGLongTextEditorView) {
        parent.onEditorLoaded?(higLongTextEditorView)
    }

    public func higLongTextEditorViewDidChange(_ higLongTextEditorView: HIGLongTextEditorView) {
        if parent.html != higLongTextEditorView.html {
            parent.html = higLongTextEditorView.html
        }
    }

    public func higLongTextEditorView(_ higLongTextEditorView: HIGLongTextEditorView, caretPositionDidChange caretPosition: CGRect) {
        parent.onCaretPositionChange?(caretPosition)
    }

    public func higLongTextEditorView(
        _ higLongTextEditorView: HIGLongTextEditorView,
        selectedTextAttributesDidChange textAttributes: HIGLongTextUITextAttributes
    ) {
        parent.textAttributes.update(from: textAttributes)
    }

    public func higLongTextEditorView(
        _ higLongTextEditorView: HIGLongTextEditorView,
        javascriptFunctionDidFail javascriptError: any Error,
        whileExecutingFunction function: String
    ) {
        parent.onJavaScriptFunctionFail?(javascriptError, function)
    }

    public func higLongTextEditorView(_ higLongTextEditorView: HIGLongTextEditorView, shouldHandleLink link: URL) -> Bool {
        return parent.handleLinkOpening?(link) ?? false
    }

    public func higLongTextEditorView(_ higLongTextEditorView: HIGLongTextEditorView, selectionDidChange selection: String) {
        parent.selection?.wrappedValue = selection
    }
}
