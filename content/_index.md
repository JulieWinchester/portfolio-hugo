---
# Leave the homepage title empty to use the site title
title: ""
date: 2022-10-24
type: landing

design:
  # Default section spacing
  spacing: "6rem"

sections:
  - block: resume-biography-3
    content:
      # Choose a user profile to display (a folder name within `content/authors/`)
      username: admin
      text: ""
      # Show a call-to-action button under your biography? (optional)
      button:
        text: Download CV
        url: uploads/Winchester_CV.pdf
    design:
      css_class: dark
      background:
        color: black
        image:
          # Add your image background to `assets/media/`.
          filename: stacked-peaks.svg
          filters:
            brightness: 1.0
          size: cover
          position: center
          parallax: false
  - block: markdown
    content:
      title: '📚 My Work'
      subtitle: ''
      text: |-
        I currently serve as the Technical Director for the MorphoSource 3D Data Repository at Duke University. Since 2017, I have helped lead MorphoSource as it has expanded from proof of concept to a uniquely powerful, complex, and collaborative platform that connects museums, researchers, and the public to rich natural history data, with emphasis on 3D content. As Co-Director of MorphoSource, I lead our development team, do full-stack web software development and development operations tasks, manage product lifecycles, engage with a global community of museum professionals and researchers, and have helped to secure and manage grant funding for informatics infrastructure.

        I'm also a Specification Editor for the International Image Interoperability Framework (IIIF), developing technical standards used by global museums and libraries for sharing contextualized digital objects such as images, audio/video, and soon 3D resources. Further, I'm a bioinformatics research affiliate at the University of Kansas Biodiversity Institute and Natural History Museum, a field leader in advancing the extended specimen and providing solutions for biodiversity digital cyberinformatics.

        My research background is in functional morphology and physical anthropology, where my Ph.D. work involved creating algorithms and tools for high-throughput specimen-based 3D phenomics, characterizing primate dentitions to answer questions about biodiversity, dietary form-function relationships, and paleoecology.

        Fundamentally, I am driven by creating cutting-edge, interoperable bio-informed data systems for natural history that benefit institutions and audiences.
    design:
      columns: '1'
  - block: markdown
    id: morphosource
    content:
      title: 'MorphoSource 3D Data Repository'
      text: |-
        <img src="/media/morphosource-screenshot.png" alt="MorphoSource platform screenshot" class="w-full rounded-lg shadow-lg ring-1 ring-gray-800">

        MorphoSource is an open-access repository that enables natural history collections and research institutions to make 3D data, images, and video of physical specimens Findable, Accessible, Interoperable, and Reusable (FAIR) at institutional scale. With over 30,000 users worldwide, the platform provides rich discoverability for collections of all sizes alongside granular access and reuse policy controls, integration with major aggregators like iDigBio and GBIF, and detailed usage tracking. By managing digital preservation standards, automated file characterization, and browser-based media previews, MorphoSource enables institutions and researchers to share high-value 3D content with colleagues and the public with minimal staff overhead.
    design:
      columns: '1'
  - block: markdown
    id: iiif
    content:
      title: 'International Image Interoperability Framework'
      text: |-
        <img src="/media/aleph-screenshot.png" alt="IIIF Aleph viewer screenshot" class="w-1/2 mx-auto block rounded-lg shadow-lg ring-1 ring-gray-800">

        The International Image Interoperability Framework (IIIF) is a set of open APIs and community-driven standards that enable cultural heritage institutions and research communities to share, display, and annotate digital objects — images, audio, video, and soon 3D resources — in an interoperable way across viewers, repositories, and institutional boundaries. For natural history collections, IIIF unlocks rich, contextual access to specimen imagery and associated annotations without requiring data to leave its home institution. As a Specification Editor, I am actively involved in shepherding and maintaining the technical specifications — including the Image and Presentation APIs — that underpin IIIF adoption across museums, libraries, and research platforms worldwide.
    design:
      columns: '1'
  - block: collection
    id: papers
    content:
      title: Recent Publications
      text: ""
      filters:
        folders:
          - publication
        exclude_featured: false
    design:
      view: citation
  - block: cta-card
    demo: true # Only display this section in the Hugo Blox Builder demo site
    content:
      title: 👉 Build your own academic website like this
      text: |-
        This site is generated by Hugo Blox Builder - the FREE, Hugo-based open source website builder trusted by 250,000+ academics like you.

        <a class="github-button" href="https://github.com/HugoBlox/hugo-blox-builder" data-color-scheme="no-preference: light; light: light; dark: dark;" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star HugoBlox/hugo-blox-builder on GitHub">Star</a>

        Easily build anything with blocks - no-code required!

        From landing pages, second brains, and courses to academic resumés, conferences, and tech blogs.
      button:
        text: Get Started
        url: https://hugoblox.com/templates/
    design:
      card:
        # Card background color (CSS class)
        css_class: "bg-primary-700"
        css_style: ""
---
