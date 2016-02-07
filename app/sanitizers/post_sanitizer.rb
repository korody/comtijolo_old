class PostSanitizer
  FILTER = {
    elements: %w[a blockquote br code del em figcaption figure h2 h3 hr img li ol p pre span strong ul],
    attributes: {
               'a' => %w[href title rel target],
      'blockquote' => %w[cite],
          'figure' => %w[class],
             'img' => %w[alt src title class],
            'span' => %w[class]
    },
    protocols: {
      a: {
        href: %w[http https]
      },
      img: {
        src: %w[http https]
      }
    }
  }
end