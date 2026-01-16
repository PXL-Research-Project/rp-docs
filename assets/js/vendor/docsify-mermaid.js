// Docsify Mermaid Plugin - Always Light Theme
(function() {
  var mermaidChart = 0;
  
  window.$docsify = window.$docsify || {};
  window.$docsify.plugins = [].concat(window.$docsify.plugins || [], function(hook) {
    hook.ready(function() {
      // Initialize mermaid when docsify is ready - ALWAYS use light theme
      if (typeof window.mermaid !== 'undefined') {
        window.mermaid.initialize({
          startOnLoad: false,
          theme: 'base',
          themeVariables: {
            primaryColor: '#f5f5f0',
            primaryTextColor: '#000000',
            primaryBorderColor: '#666666',
            lineColor: '#333333',
            secondaryColor: '#e8e8e4',
            tertiaryColor: '#f5f5f0',
            background: '#faf9f7',
            mainBkg: '#f5f5f0',
            secondBkg: '#e8e8e4',
            tertiaryBkg: '#f5f5f0',
            clusterBkg: '#f5f5f0',
            altBackground: '#faf9f7',
            edgeLabelBackground: '#faf9f7',
            nodeTextColor: '#000000',
            sectionBkgColor: '#f5f5f0',
            actorBorder: '#666666',
            actorBkg: '#f5f5f0',
            actorTextColor: '#000000',
            actorLineColor: '#333333',
            signalColor: '#333333',
            signalTextColor: '#000000'
          }
        });

        // Add CSS to force light background for mermaid diagrams
        const style = document.createElement('style');
        style.textContent = `
          .mermaid {
            background-color: #faf9f7 !important;
            padding: 20px !important;
            border-radius: 8px !important;
            margin: 20px 0 !important;
            border: 1px solid #e0e0e0 !important;
          }
          .mermaid svg { 
            background-color: #faf9f7 !important;
            color: #000000 !important;
          }
          .mermaid .cluster rect,
          .mermaid .node rect,
          .mermaid .node circle,
          .mermaid .node ellipse,
          .mermaid .node polygon {
            fill: #f5f5f0 !important;
            stroke: #666666 !important;
            stroke-width: 2px !important;
          }
          .mermaid .edgeLabel { 
            background-color: #faf9f7 !important; 
            color: #000000 !important;
          }
          .mermaid text { 
            fill: #000000 !important; 
          }
          .mermaid .label {
            color: #000000 !important;
            fill: #000000 !important;
          }
        `;
        document.head.appendChild(style);
      }
    });
    
    hook.doneEach(function() {
      // Process mermaid diagrams after each page load
      if (typeof window.mermaid !== 'undefined') {
        var mermaidElements = document.querySelectorAll('.lang-mermaid, .language-mermaid');
        if (mermaidElements.length > 0) {
          mermaidElements.forEach(function(element) {
            var code = element.textContent;
            var mermaidDiv = document.createElement('div');
            mermaidDiv.className = 'mermaid';
            mermaidDiv.textContent = code;
            element.parentNode.replaceChild(mermaidDiv, element);
          });
          
          // Re-initialize mermaid with forced light theme
          window.mermaid.init(undefined, document.querySelectorAll('.mermaid'));
        }
      }
    });
  });
})();
