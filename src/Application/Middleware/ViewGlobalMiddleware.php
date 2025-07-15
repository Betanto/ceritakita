<?php

namespace App\Application\Middleware;

class ViewGlobalMiddleware
{
    protected $container;

    public function __construct($container)
    {
        $this->container = $container;
    }

    public function __invoke($request, $handler)
    {

        $db = $this->container->get('db');
        $footerArticles = $db->select('tbl_articles', ['id', 'title', 'slug', 'content'], [
            'status' => 1,
            'deleted_at' => null,
            'slug' => 'artikel-footer'
        ]);
        // $socialMedia = $db->select('tbl_articles', ['id', 'title', 'slug', 'content'], [
        //     'status' => 1,
        //     'deleted_at' => null,
        //     'slug' => 'sosial-media'
        // ]);
        $socialMedia = $db->select('tbl_articles (a)', [
            '[><]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[><]tbl_categories (c)' => ['ac.id_category' => 'id']
        ], [
            'a.id',
            'a.title',
            'a.slug',
            'a.image',
            'a.file',
            'a.status',
            'a.content',
            'a.created_at',
            'c.slug (category_slug)',
        ], [
            'a.status' => 1,
            'a.deleted_at' => null,
            'c.slug' => 'sosial-media'
        ]);

        if ($this->container->has('view')) {
            $this->container->get('view')->getEnvironment()->addGlobal('footer_articles', $footerArticles);
            $this->container->get('view')->getEnvironment()->addGlobal('social_media', $socialMedia);
        }

        return $handler->handle($request);
    }
}
