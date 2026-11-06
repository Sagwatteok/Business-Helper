<%@ tag pageEncoding="UTF-8" body-content="scriptless" %>
<%@ attribute name="eyebrow" required="true" %>
<%@ attribute name="title" required="true" %>
        <header class="top-header">
            <div>
                <p class="page-eyebrow">${eyebrow}</p>
                <h1>${title}</h1>
            </div>

            <jsp:doBody />
        </header>
